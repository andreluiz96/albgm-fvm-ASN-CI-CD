variable "node_role_arn" {
  description = "ARN da role IAM usada pelos nodes"
  type        = string
}

variable "ssh_key_name" {
  description = "Nome da chave SSH para acesso remoto"
  type        = string
}

variable "todo_image" {
  description = "Imagem da aplicação To-do List"
  type        = string
}