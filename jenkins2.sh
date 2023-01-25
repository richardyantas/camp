
# pipeline {
#     agent any
#     tools {
#         terraform 'terraform-11'
#     }
#     stages{
#         stage('Git Checkout'){
#             steps{
#                 git branch: 'main', url: 'https://github.com/richardyantas/camp.git'
#             }
#         }
#         stage('Terraform Init'){
#             steps{
#                 sh '''terraform init'''
#             }
#         }
#     }
# }


# pipeline {
#     agent any
#     tools {
#         terraform 'terraform-11'
#     }
#     stages{
#         stage('Git Checkout'){
#             steps{
#                 git branch: 'main', url: 'https://github.com/richardyantas/camp.git'
#             }
#         }
#         stage('Terraform Init'){
#             steps{
#                 sh '''terraform init'''
#             }
#         }
#     }
# }