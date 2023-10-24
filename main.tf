data "aws_eks_cluster" "default" {
    name = var.cluster_name
}
data "aws_eks_cluster_auth" "default" {
    name = var.cluster_name
}
provider "kubernetes" {
    host = data.aws_eks_cluster.default.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
    token = data.aws_eks_cluster_auth.default.token
}
provider "helm" {
    kubernetes {
      host = data.aws_eks_cluster.default.endpoint
      cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
      token = data.aws_eks_cluster_auth.default.token
    }
}
resource "helm_release" "mailu" {
    name = "mailu"
    repository = "https://mailu.github.io/helm-charts/"
    chart = "mailu"

    values = [
        "${file("${path.module}/values-files/values.yaml")}"
    ]
}