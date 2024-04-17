package erratum

func Use(opener ResourceOpener, input string) (err error) {
	res, err := opener()
	switch err.(type) {
	case nil:
	case TransientError:
		return Use(opener, input)
	default:
		return

	}

	defer res.Close()

	defer func() {
		if r := recover(); r != nil {
			if v, ok := r.(FrobError); ok {
				res.Defrob(v.defrobTag)
			}
			err = r.(error)
		}
	}()

	res.Frob(input)

	return
}
