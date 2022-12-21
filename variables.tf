variable "name" {
  type        = string
  description = "module/repo-folder/workspace name and uniq identifier"
}

variable "module_source" {
  type        = string
  description = "The module source"
}

variable "module_version" {
  type        = string
  description = "The module version"
}

variable "workspace" {
  type = object({
    org                 = string
    tags                = optional(list(string), null)
    description         = optional(string, null)
    directory           = optional(string, "./") # this is seems supposed to be the root directory of git repo
    global_remote_state = optional(bool, true)   # allow org workspaces access to this workspace state, TODO: there is a way to implement specific workspaces whitelisting using remote_state_consumer_ids, needs apply and testing

  })

  description = "Terraform cloud workspace configurations"
}

variable "module_vars" {
  type        = any
  default     = {}
  description = "The module variables"
}

variable "target_dir" {
  type        = string
  default     = "./"
  description = "The directory where new module folder will be created, this will be terraform project repository root url"
}

variable "terraform_version" {
  type        = string
  default     = ">= 1.3.0"
  description = "The required_version variable value for terraform{} block in versions.tf"
}

variable "module_providers" {
  type = list(object({
    name        = string
    version     = string
    source      = optional(string)
    alias       = optional(string)
    custom_vars = optional(any, {})
  }))
  default     = []
  description = "The list of providers to add in providers.tf"
}

variable "terraform_backend" {
  type = object({
    name    = string
    configs = optional(any, {})
  })
  default     = { name = null, configs = null }
  description = "Allows to set terraform backend configurations"
}

variable "repo" {
  type = object({
    identifier         = string                  # <organization>/<repository> format repo identifier
    branch             = optional(string, null)  # will default to repo default branch if not set
    ingress_submodules = optional(string, false) # whether to fetch submodules a]when cloning vcs  
    oauth_token_id     = optional(string, null)  # the auth token generated by resource tfe_oauth_client
    tags_regex         = optional(string, null)  # regular expression used to trigger Workspace run for matching Git tags
  })
  default     = null
  description = "git/vcs repository configurations"
}

variable "variable_set_ids" {
  type        = list(string)
  default     = null
  description = "The list of variable set ids to attach to workspace"
}

variable "linked_workspaces" {
  type        = list(string)
  default     = null
  description = "The list of workspaces from where we can pull outputs and use in our module variables"
}