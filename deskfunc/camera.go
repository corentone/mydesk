package deskfunc

import (
	"math/rand"
	"time"
)

func randomString(strlen int) string {

	if strlen <= 0 {
		return ""
	}

	rand.Seed(time.Now().UTC().UnixNano())
	const chars = "abcdefghijklmnopqrstuvwxyz0123456789"
	result := make([]byte, strlen)
	for i := 0; i < strlen; i++ {
		result[i] = chars[rand.Intn(len(chars))]
	}
	return string(result)
}

func TakePicture() string {
	return ""
}
