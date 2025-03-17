package foofoo

import (
	"testing"
)

func TestMultiply(t *testing.T) {
	t.Parallel()
	if Multiply(2, 3) != 6 {
		t.Error("fail")
	}
}

func TestReadFile(t *testing.T) {
	t.Parallel()
	s, err := readFile("testdata/data.txt")
	if err != nil {
		t.Error(err)
	}
	if s != "foofoo" {
		t.Error("fail")
	}
}
