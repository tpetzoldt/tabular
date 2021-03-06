#' Check (primary) key constraints
#'
#' Check for violation of a (primary) key constraint
#'
#' @param x Data frame representing a table of a data base.
#' @param cols Names of the colum(s) of \code{x} to which the constraint
#'   applies (vector of type character).
#' @param silent Logical. If \code{FALSE}, details on constraint
#'  violations are shown using \code{\link[base]{print}}.
#' 
#' @return \code{TRUE} if the check was passed successfully and
#'   \code{FALSE} otherwise.
#'
#' @note The function performs a check for duplicates (using 
#'   \code{\link{check.unique}}) and missing values
#'   (using \code{\link{check.notnull}}). If \code{cols} has length > 1,
#'   this is interpreted as a composite key (and not as a set of
#'   individual key columns). See the examples.
#'
#' @seealso There are more functions to check constraints, namely
#'   \code{\link{check.notnull}}, \code{\link{check.unique}},
#'   and \code{\link{check.link}}.
#'   See also the example for \code{\link{db.read}}.
#'
#' @author David Kneis \email{david.kneis@@tu-dresden.de}
#'
#' @export
#'
#' @examples
#'
#' data(temperature)
#' print(temperature)
#' 
#' # Should succeed
#' check.key(temperature, c("day", "city"))
#' 
#' # Duplicates not allowed in keys
#' temperature[2, "day"] <- 1
#' print(temperature)
#' check.key(temperature, c("day", "city"))

#' # Missing values not allowed in keys
#' temperature[2, "day"] <- NA
#' check.key(temperature, c("day", "city"))

check.key <- function(x, cols, silent=FALSE) {
  ok <- check.unique(x, cols, silent) && check.notnull(x, cols, silent)
  if (!ok && !silent)
    print(paste0("data in 'x' violate key constraint with regard ",
      "to the column(s) '",paste(cols, collapse="', '")))
  return(ok)
}
