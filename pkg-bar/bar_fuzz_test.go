package bar_test

import (
	"testing"

	bar "github.com/aileron-project/scripts/pkg-bar"
)

func FuzzReverse(f *testing.F) {
	f.Fuzz(func(t *testing.T, x int, y int) {
		sum := bar.Add(x, y)
		if sum != x+y {
			t.Errorf("want: %q, got: %q", x+y, sum)
		}
	})
}
