package foo_test

import (
	"testing"

	foo "github.com/aileron-project/scripts/pkg-foo"
)

func TestAdd(t *testing.T) {
	t.Parallel()
	if foo.Add(1, 2) != 3 {
		t.Error("fail")
	}
}

func TestSub(t *testing.T) {
	t.Parallel()
	if foo.Sub(1, 2) != -1 {
		t.Error("fail")
	}
}

func TestReadFile(t *testing.T) {
	t.Parallel()
	s, err := foo.ReadFile("testdata/data.txt")
	if err != nil {
		t.Error(err)
	}
	if s != "foo" {
		t.Error("fail")
	}
}
