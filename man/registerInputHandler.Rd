% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/server-input-handlers.R
\name{registerInputHandler}
\alias{registerInputHandler}
\title{Register an Input Handler}
\usage{
registerInputHandler(type, fun, force = FALSE)
}
\arguments{
\item{type}{The type for which the handler should be added --- should be a
single-element character vector.}

\item{fun}{The handler function. This is the function that will be used to
parse the data delivered from the client before it is available in the
\code{input} variable. The function will be called with the following three
parameters: \enumerate{ \item{The value of this input as provided by the
client, deserialized using jsonlite.} \item{The \code{shinysession} in which the
input exists.} \item{The name of the input.} }}

\item{force}{If \code{TRUE}, will overwrite any existing handler without warning.
If \code{FALSE}, will throw an error if this class already has a handler
defined.}
}
\description{
Adds an input handler for data of this type. When called, Shiny will use the
function provided to refine the data passed back from the client (after being
deserialized by jsonlite) before making it available in the \code{input} variable
of the \code{server.R} file.
}
\details{
This function will register the handler for the duration of the R process
(unless Shiny is explicitly reloaded). For that reason, the \code{type} used
should be very specific to this package to minimize the risk of colliding
with another Shiny package which might use this data type name. We recommend
the format of "packageName.widgetName". It should be called from the
package's \code{.onLoad()} function.

Currently Shiny registers the following handlers: \code{shiny.matrix},
\code{shiny.number}, and \code{shiny.date}.

The \code{type} of a custom Shiny Input widget will be deduced using the
\code{getType()} JavaScript function on the registered Shiny inputBinding.
}
\examples{
\dontrun{
# Register an input handler which rounds a input number to the nearest integer
# In a package, this should be called from the .onLoad function.
registerInputHandler("mypackage.validint", function(x, shinysession, name) {
  if (is.null(x)) return(NA)
  round(x)
})

## On the Javascript side, the associated input binding must have a corresponding getType method:
getType: function(el) {
  return "mypackage.validint";
}

}
}
\seealso{
\code{\link[=removeInputHandler]{removeInputHandler()}} \code{\link[=applyInputHandlers]{applyInputHandlers()}}
}
