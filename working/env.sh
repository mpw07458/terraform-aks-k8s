#!/usr/bin/env bash
echo "Setting environment variables for Terraform"
export ARM_SUBSCRIPTION_ID=c54754af-0163-41e0-a035-f4141c7dffd4
export ARM_CLIENT_ID=2bd77c4d-717c-494f-956d-a1cbfdf10b72
export ARM_CLIENT_SECRET=bdcf1977-76fe-4d55-b694-bcee318d52c3
export ARM_TENANT_ID=e76efe09-e72e-4839-8934-5ff7c4480bb0

# Not needed for public, required for usgovernment, german, china
export ARM_ENVIRONMENT=public
