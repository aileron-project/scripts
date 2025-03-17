package xxx_test

import (
	"testing"

	"github.com/aileron-project/scripts/pkg-foo/internal/xxx"
)

func TestFuncXXX(t *testing.T) {
	if xxx.FuncXXX() != "xxx" {
		t.Error("fail")
	}
}
