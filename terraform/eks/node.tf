module "node_group" {
    source = "../modules/node_group"

    node_group_name = "${var.cluster_name}-NodeGroup-${local.datetime}"
    cluster_name = var.cluster_name

    node_role_arn = aws_iam_role.eks_instance_role.arn
    subnet_ids = [
        data.terraform_remote_state.vpc.outputs.subnet_app_a_id,
        data.terraform_remote_state.vpc.outputs.subnet_app_b_id,
        data.terraform_remote_state.vpc.outputs.subnet_app_c_id
    ]

    ## This SG assigns only for "which SG could ACCESS nodes from 22 port". Normally we will given a SG which allows all internal traffic.
    security_group_ids = [aws_security_group.node.id]

    desired_capacity = var.node_desired_capacity
    max_capacity = var.node_max_capacity
    min_capacity = var.node_min_capacity

    disk_size = var.node_disk_size
    instance_type = var.node_instance_type
    ami_release_version = "1.15.10-20200228"
    ssh_key_pair = var.key_pair_name

    node_group_depends_on = [aws_eks_cluster.main]
    node_tags = {}

}