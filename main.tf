module "eks" {
  source       = "./terraform-aws-eks"
  cluster_name = "terraform-eks-${terraform.workspace}"
  subnets      = ["${data.terraform_remote_state.vpc.private_subnets}"]
  vpc_id       = "${data.terraform_remote_state.vpc.vpc_id}"

  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  worker_groups = [
    {
      instance_type = "m5.large"
      asg_max_size  = 5
    },
  ]

  tags {
    Name = "terraform-eks-${terraform.workspace}"
  }
}
