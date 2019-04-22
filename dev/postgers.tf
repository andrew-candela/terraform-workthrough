# module "postgres" {
#   source            = "../modules/postgres"
#   identifier        = "attribute-store"
#   instance_class    = "db.t2.micro"
#   env               = "dev"
#   access_key        = "${var.access_key}"
#   secret_key        = "${var.secret_key}"
#   allocated_storage = 10
#   name              = "attribute_database_kafka_test"
#   password          = "${var.postgres_password}"
#   username          = "${var.postgres_username}"
#   port              = 5432
# }

