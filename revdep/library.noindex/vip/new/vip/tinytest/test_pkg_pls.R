# Exits
if (!requireNamespace("caret", quietly = TRUE)) {
  exit_file("Package 'caret' missing")
}
if (!requireNamespace("pls", quietly = TRUE)) {
  exit_file("Package 'pls' missing")
}

# # Load required packages
# suppressMessages({
#   library(caret)
#   library(pls)
# })

# Generate Friedman benchmark data
friedman1 <- gen_friedman(seed = 101)

# Fit model(s)
fit <- pls::mvr(y ~ ., data = friedman1)

# Compute VI scores
vis <- vi_model(fit)

# Expectations for `vi_model()`
expect_identical(
  current = vis$Importance,
  target = caret::varImp(fit)$Overall
)

# Expectations for `get_training_data()`
expect_identical(
  current = vip:::get_training_data.default(fit),
  target = friedman1
)

# Expectations for `get_feature_names()`
expect_identical(
  current = vip:::get_feature_names.mvr(fit),
  target = paste0("x", 1L:10L)
)
