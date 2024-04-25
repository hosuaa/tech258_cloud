# Azure

## Azure Basics
Azure is a cloud provider launched by Microsoft that offers a variety of services, including computing power, storage, and networking, among others, over the internet - the cloud. 
## Azure regions
**Azure Regions**: Azure regions are geographical areas where Azure resources are located. Each region is made up of one or more data centers that are in close proximity to each other. This setup ensures redundancy and fault tolerance. Azure regions are spread across the globe to provide low-latency access to services for users in different parts of the world.

**Availability Zones**: Availability Zones are physically separate data centers within an Azure region. They are designed to provide high availability and fault tolerance by ensuring that if one zone fails, resources can automatically failover to another zone within the same region. This setup enhances resilience and helps minimize downtime.
## How Azure is structured
Azure is structured into 4 different management levels:

1. Management groups
   - Multiple subscriptions. All subscriptions in a management group automatically inherit the conditions that are applied to the management group
   - Like folders, you can have groups inside groups (up to 6 levels)
   - There must be a root management group
2. Subscriptions
   - Associate users with the resources they create. "Payment account".
   - Limits and quotas e.g. 50 identical VMs per region (e.g. Ireland)
3. Resource groups
   - Containers where you deploy/manage resources
4. Resources
   - Instances of services you create e.g. VMs, databases

![image](images/azure_structured.png)

These groups have different scopes so that we can set different access and policies per scope.
## Types of service does Azure provide

- Infrastructure as a Service (IaaS)
- Platform as a Service (PaaS)
- Software as a Service (SaaS)
- Database services
- Developer tools
- AI and Machine Learning services
- Internet of Things (IoT) services
- Security and Identity services
- and more...
## Ways to access Azure
Users can access Azure through:

- Azure Portal (web-based interface)
- Azure CLI
- Azure PowerShell
- RESTful APIs
- Software Development Kits (SDKs) for various programming languages
- Azure mobile app
## Azure vs Azure DevOps
Azure is the cloud provider that offers the services for building, deploying, and managing applications and services, while Azure DevOps is a set of development tools provided by Microsoft to help teams collaborate on software development projects. Azure DevOps includes services for version control, build automation, release management, and project management.
## Azure Pricing Calculator
The Azure Pricing Calculator is a tool provided by Microsoft to help users estimate the cost of using Azure services. It allows users to input their requirements and usage patterns to get an estimate of the monthly cost. This helps users plan and budget for their Azure usage more effectively.

## Azure vs AWS
Azure is prefereable to AWS for smaller businesses who need faster deployment. They don't need the extra services provided by AWS, even if AWS may be cheaper 'in bulk'. Think of a supermarket vs corner shop for a customer, AWS is the supermarket and Azure is the corner shop, and so Azure is generally more convienient for smaller customers. 

Azure has a strong enterprise client base.

Azure integrates with the Microsoft ecosystem well. For example, if you have Microsoft 365 set up, you already have an Azure account. On AWS, you would have to create the account manually. 

At the end of the day, the decisions made for choosing a cloud provider are driven by the skills of the organisation (if you don't know GCP, you are not going to suggest to use it)