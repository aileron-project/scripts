package foo_test

import (
	"math"
	"math/rand/v2"
	"testing"

	foo "github.com/aileron-project/scripts/pkg-foo"
)

func BenchmarkAdd(b *testing.B) {
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		x := rand.IntN(math.MaxInt)
		y := rand.IntN(math.MaxInt)
		foo.Add(x, y)
	}
}
