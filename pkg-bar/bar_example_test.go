package bar_test

import (
	"fmt"

	bar "github.com/aileron-project/scripts/pkg-bar"
)

func ExampleAdd() {
	x, y := 1, 2
	sum := bar.Add(x, y)
	fmt.Println(sum)
	// Output:
	// 3
}
