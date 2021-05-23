// Indicates if modules has been run to completion
output "complete" {
  value = "${join("", helm_release.hdfs.*.id)}"
}