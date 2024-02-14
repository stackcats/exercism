package letter

type FreqMap map[rune]int

func Frequency(text string) FreqMap {
	frequencies := FreqMap{}
	for _, r := range text {
		frequencies[r]++
	}
	return frequencies
}

func ConcurrentFrequency(texts []string) FreqMap {
	ch := make(chan FreqMap, len(texts))
	for _, text := range texts {
		go func(s string) {
			ch <- Frequency(s)
		}(text)
	}

	ans := FreqMap{}
	for i := 0; i < len(texts); i++ {
		mp := <-ch
		for k, v := range mp {
			ans[k] += v
		}
	}
	return ans
}
