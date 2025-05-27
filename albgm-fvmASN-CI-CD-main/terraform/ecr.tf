resource "aws_ecr_repository" "todo_repo" {
  name         = "todo-list-dp007"
  force_delete = true
}