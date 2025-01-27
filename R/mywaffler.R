#' Create Waffle Charts
#'
#' A function to create waffle charts for categorical data visualization.
#'
#' @param df A data frame containing the data to be visualized.
#' @param category_col A string specifying the column name in `df` for categories.
#' @param value_col A string specifying the column name in `df` for values.
#' @param color_col A string specifying the column name in `df` for colors (optional).
#'   If NULL, a default color palette will be used.
#'
#' @importFrom graphics par plot rect text
#' @importFrom RColorBrewer brewer.pal
#' @examples
#' # Example usage:
#' data <- data.frame(
#'   Category = c("A", "B", "C"),
#'   Value = c(70, 50, 90),
#'   Color = c("red", "blue", "green")
#' )
#' mywaffler(data, category_col = "Category", value_col = "Value", color_col = "Color")
#'
#' @export

globalVariables(c("par", "rect", "text", "graphics"))

mywaffler <- function(df, category_col, value_col, color_col = NULL) {
  # Check if the required columns exist
  if (!category_col %in% names(df)) {
    stop(paste("Column", category_col, "not found in the data frame"))
  }
  if (!value_col %in% names(df)) {
    stop(paste("Column", value_col, "not found in the data frame"))
  }

  # Default colors if color_col is not provided
  if (is.null(color_col)) {
    num_categories <- nrow(df)
    default_colors <- grDevices::rainbow(num_categories) # Compatible color palette
    df$color_col <- default_colors # Add a default color column
    color_col <- "color_col"
  } else {
    if (!color_col %in% names(df)) {
      stop(paste("Column", color_col, "not found in the data frame"))
    }
  }

  # Parameters for the waffle chart
  total_squares <- 100
  rows <- 10
  cols <- 10

  # Function to create a single vertical waffle chart
  plot_waffle_vertical <- function(data, primary_color, title) {
    grid_x <- rep(cols:1, rows)
    grid_y <- rep(1:rows, each = cols)

    plot(1, type = "n", xlim = c(0.5, cols + 0.5), ylim = c(0.5, rows + 0.5),
         xaxt = "n", yaxt = "n", xlab = "", ylab = "", bty = "n", asp = 1, main = title)

    squares_primary <- round(data / 100 * total_squares)
    squares_gray <- total_squares - squares_primary

    rect(
      xleft = grid_x[1:squares_primary] - 0.5,
      ybottom = grid_y[1:squares_primary] - 0.5,
      xright = grid_x[1:squares_primary] + 0.5,
      ytop = grid_y[1:squares_primary] + 0.5,
      col = primary_color,
      border = "white"
    )

    rect(
      xleft = grid_x[(squares_primary + 1):total_squares] - 0.5,
      ybottom = grid_y[(squares_primary + 1):total_squares] - 0.5,
      xright = grid_x[(squares_primary + 1):total_squares] + 0.5,
      ytop = grid_y[(squares_primary + 1):total_squares] + 0.5,
      col = "gray90",
      border = "white"
    )

    text(x = (cols + 1) / 2, y = (rows + 1) / 2, labels = paste0(round(data, 2), "%"), cex = 1, font = 2, col = "black")
  }

  # Determine grid layout based on the number of categories
  num_categories <- nrow(df)
  num_rows <- ceiling(sqrt(num_categories))
  num_cols <- ceiling(num_categories / num_rows)
  par(mfrow = c(num_rows, num_cols), mar = c(0.5, 0.5, 1, 0.5))

  # Loop to create a waffle chart for each category
  for (i in 1:num_categories) {
    plot_waffle_vertical(
      data = df[[value_col]][i],
      primary_color = df[[color_col]][i %% length(df[[color_col]]) + 1],
      title = df[[category_col]][i]
    )
  }
}
