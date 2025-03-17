package foo_test

import (
	"testing"

	foo "github.com/aileron-project/scripts/pkg-foo"
)

func FuzzReverse(f *testing.F) {
	f.Fuzz(func(t *testing.T, x int, y int) {
		sum := foo.Add(x, y)
		if sum != x+y {
			t.Errorf("want: %q, got: %q", x+y, sum)
		}
	})
}
