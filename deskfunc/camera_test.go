package deskfunc

import (
	"os"
	"testing"
)

func Test_randomString(t *testing.T) {
	strlengths := [...]int{1, 5, -1, 122}
	var s string

	for _, strlen := range strlengths {
		s = randomString(strlen)
		if len(s) != strlen && strlen >= 0 {
			t.Error("String len doesn't match. Got: ", s, " asked: ", strlen)
		} else if len(s) != 0 && strlen < 0 {
			t.Error("String len doesn't match. Got: ", s, " asked: ", strlen)
		}
	}
}

func Test_TakePicture(t *testing.T) {
	filename := TakePicture()

	if len(filename) < 5 || filename[len(filename)-5:] != ".jpeg" {
		t.Error("Expected .jpeg extension, got: ", filename)
		return
	}

	if _, err := os.Stat(filename); os.IsNotExist(err) {
		t.Errorf("%s doesn't exist.", filename)
	}
}
