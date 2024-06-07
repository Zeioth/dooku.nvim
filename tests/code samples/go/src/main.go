/*
To test, you should initialize this module first as "go mod init user".
Then you can run godoc and visit it on localhost:6060/pkg/user
*/

// name of the package.
package user

// fmt is responsible for formatting
import (
    "fmt"
)

// User is a struct of human data
type User struct {
    Age int
    Name string
}

func main() {
    // human is an initialization of the User struct
    human := User {
        Age: 0,
        Name: "person",
    }

    fmt.Println(human.Talk())
}

// Talk is a method of the User struct
func (receiver User) Talk() string {
    return "Every User Gets to Say Something!"
}
