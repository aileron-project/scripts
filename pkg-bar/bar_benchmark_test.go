package bar_test

import (
	"math"
	"math/rand/v2"
	"testing"

	bar "github.com/aileron-project/scripts/pkg-bar"
)

func BenchmarkAdd(b *testing.B) {
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		x := rand.IntN(math.MaxInt)
		y := rand.IntN(math.MaxInt)
		bar.Add(x, y)
	}
}
