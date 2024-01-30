class Raindrops
  def self.convert(n)
    s = ''
    for i, t in [[3, 'Pling'], [5, 'Plang'], [7, 'Plong']] do
      if n % i == 0
        s += t
      end
    end
    s == '' ? "#{n}" : s
  end
end
