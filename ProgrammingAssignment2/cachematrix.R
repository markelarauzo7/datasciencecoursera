
## It creates what is called a 'special' matrix in the submission wording.
## Basically, it creates some kind of handler (which is essentially a list)
## for our matrix, where we can store and modify data. In our case, the 
## inverse. 

makeCacheMatrix <- function(x = matrix()) {
    ## inversed matrix stored variable
    m <- NULL
    ## Every time the matrix is changed m is emptied
    ## ensuring data reliability 
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setInverse <- function(inv_matrix) m <<- inv_matrix 
    getInverse <- function() m
    list(set = set, get = get,
         setInverse = setInverse,
         getInverse = getInverse)
}


## processes provided 'special' matrix. It calculates the inverse if
## it has not previously been done and stores this inversed matrix   

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    m <- x$getInverse()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- solve(data)
    x$setInverse(m)
    m
}
