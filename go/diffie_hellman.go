package diffiehellman

import (
	"math/big"
	"math/rand"
	"time"
)

// Diffie-Hellman-Merkle key exchange
// Private keys should be generated randomly.

func PrivateKey(p *big.Int) *big.Int {
	seed := rand.New(rand.NewSource(time.Now().UnixNano()))
	limit := new(big.Int).Sub(p, big.NewInt(2))
	rand := new(big.Int).Rand(seed, limit)
	return rand.Add(rand, big.NewInt(2))
}

func PublicKey(private, p *big.Int, g int64) *big.Int {
	return new(big.Int).Exp(big.NewInt(g), private, p)
}

func NewPair(p *big.Int, g int64) (*big.Int, *big.Int) {
	private := PrivateKey(p)
	public := PublicKey(private, p, g)
	return private, public
}

func SecretKey(private1, public2, p *big.Int) *big.Int {
	return new(big.Int).Exp(public2, private1, p)
}
