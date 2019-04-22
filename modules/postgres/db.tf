resource "aws_db_instance" "attribute_database" {
  identifier = "${var.identifier}"

  engine            = "postgres"
  engine_version    = "11.1"
  instance_class    = "${var.instance_class}"    # instance_class    = "db.t2.micro"
  allocated_storage = "${var.allocated_storage}"

  name     = "${var.name}"
  username = "${var.username}"
  password = "${var.password}"
  port     = "${var.port}"

  # iam_database_authentication_enabled = true

  vpc_security_group_ids = ["sg-561f3531"]
  skip_final_snapshot = true

  # maintenance_window = "Mon:00:00-Mon:03:00"
  # backup_window      = "03:00-06:00"


  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  # monitoring_interval = "30"


  # monitoring_role_name   = "MyRDSMonitoringRole"
  # create_monitoring_role = true

  tags = {
    Owner = "andrew"
    Name  = "${var.env}-postgres-kafka-test"
    Type  = "Kafka_testing"
  }

  # DB subnet group
  # subnet_ids = ["subnet-12345678", "subnet-87654321"]
  # DB parameter group
  # family = "mysql5.7"
  # DB option group
  # major_engine_version = "5.7"
  # Snapshot name upon DB deletion
  # final_snapshot_identifier = "demodb"
  # Database Deletion Protection
  # deletion_protection = true
  # parameters = [
  #   {
  #     name  = "character_set_client"
  #     value = "utf8"
  #   },
  #   {
  #     name  = "character_set_server"
  #     value = "utf8"
  #   },
  # ]
  # options = [
  #   {
  #     option_name = "MARIADB_AUDIT_PLUGIN"

  #     option_settings = [
  #       {
  #         name  = "SERVER_AUDIT_EVENTS"
  #         value = "CONNECT"
  #       },
  #       {
  #         name  = "SERVER_AUDIT_FILE_ROTATIONS"
  #         value = "37"
  #       },
  #     ]
  #  },
  # ]
}
