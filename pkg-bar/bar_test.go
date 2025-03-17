package bar_test

import (
	"testing"

	bar "github.com/aileron-project/scripts/pkg-bar"
)

func TestAdd(t *testing.T) {
	t.Parallel()
	if bar.Add(1, 2) != 3 {
		t.Error("fail")
	}
}

func TestSub(t *testing.T) {
	t.Parallel()
	if bar.Sub(1, 2) != -1 {
		t.Error("fail")
	}
}

func TestReadFile(t *testing.T) {
	t.Parallel()
	s, err := bar.ReadFile("testdata/data.txt")
	if err != nil {
		t.Error(err)
	}
	if s != "bar" {
		t.Error("fail")
	}
}
