resource "helm_release" "bookinfo" {
  name             = "bookinfo"
  namespace        = "bookinfo"
  create_namespace = true
  chart            = "../bookinfo/chart"
}