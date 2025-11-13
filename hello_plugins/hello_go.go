package main
import "C"
import "fmt"
//export hello_world
func hello_world() {
    fmt.Println("Hello, Go!")
}
func main() {}
