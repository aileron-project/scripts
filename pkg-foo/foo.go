package foo

import (
	"os"

	"gopkg.in/yaml.v3"
)

// Add returns x + y.
func Add(x, y int) int {
	return x + y
}

// Sub returns x - y.
func Sub(x, y int) int {
	return x - y
}

// ReadFile returns the content of given file.
func ReadFile(path string) (string, error) {
	b, err := os.ReadFile(path)
	if err != nil {
		return "", err
	}
	return string(b), nil
}

// UnmarshalYAML returns the unmarshaled content.
func UnmarshalYAML(in []byte) (map[string]any, error) {
	m := map[string]any{}
	err := yaml.Unmarshal(in, &m)
	return m, err
}
