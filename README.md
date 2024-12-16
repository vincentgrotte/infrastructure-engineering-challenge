## Requirements

1. Using AWS or GCP, create a website that displays some static text.
2. Text should include your name

## Steps

- Create personal AWS account
- Create AWS root access key (bad practice - fine for this exercise)
- Create cloudformation template
    - ./cfn-templates/stack.yaml
- Modify the template to create an S3 bucket
    - Configure S3 bucket to serve static content
    - Configure S3 bucket to allow public access policy (bad practice - fine for this exercise)
- Create shell scripts to create and delete the cloudformation stack and resources
    - ./scripts/create-stack.sh
    - ./scripts/delete-stack.sh
- Modify the script file permissions to be able to execute
    - chmod +x ./scripts/create-stack.sh
    - chmod +x ./scripts/delete-stack.sh
- Create the following static content:
    - ./static-content/index.html (main page, contains my name)
    - ./static-content/error.html (error page)
- Create a Makefile to run the scripts from the root of the repository
- Deploy the stack
- Test the website:
    - http://infra-eng-challenge-bucket.s3-website-ap-southeast-2.amazonaws.com/
    - http://infra-eng-challenge-bucket.s3-website-ap-southeast-2.amazonaws.com/bad-path (Will show error page)
- Delete the stack to save cost

Time taken to build the solution: 1 hour

## Additional Questions

### What else you would do with your website, and how you would go about doing it if you had more time?

The possibilities are endless in terms of the features of the website. I could make a game, a video-hosting site, a blog, anything. I would go about this the same way I made this site, by using web-search to aid myself in finding the correct commands and syntax for concepts I already understand.

I could have a custom domain, I skipped this in favour of the default domain assigned to the bucket. If I had more time maybe I would try to find a fun domain name to use. I would be able to use Route53 (AWS) to install this.

If there were any features with logical aspects I would implement unit tests, probably with Jest, as I am most familiar with it as a testing library.

Regarding the non-functional aspects of the website, the most obvious to me is that I could make it more secure. A simple way to do this would be to use the pre-existing, open-source template for a static CloudFront site. This would come with HTTPS, secure headers, and best-practice access policies. It would mean that visitors would not be connecting directly to my bucket but to CloudFront, which would then talk to the bucket.

On a side note and unrelated to security, this would also mean that my site would be served via CDN, which should make it load faster.

### Alternative solutions that you could have taken but didn’t and explain why.

I could have used GCP but I used AWS because I have spent so much time with it these past 3 years that it was faster. Using GCP and App Engine or their static hosting alternative would have taken additional reading time.

I could have skipped the stack creation but it seemed to be more in the spirit of "Infrastructure Engineering Challenge". It also speeds up the process of deleting and re-creating the whole thing.

I could have used another AWS offering, like a Lambda, to return some html, this would have been more complex than the simple static site and taken more time.

In the previous answer, I described using CloudFront, this is certainly a good, more robust alternative. I didn't do this because it was overkill for the project and seemed against the spirit of the challenge, as I would largely be able to plug-and-play with the CloudFront solution.

### What would be required to make this a production grade website that would be developed on by various development teams?

To me, "production grade" means a few things at minimum - I consider the following to be critical:
- Unit tests for any kind of real feature. This helps against regression, enables test-driven-development, and eases the mental load on the developer as they can focus more on their current work, whatever that may be: a feature, a release, a hotfix, and so on.
- CI/CD pipelines that run the unit tests, the linter, and some form of security scanning, at minimum. This also provides a history of what was deployed and when. Makes it easier to roll back. This is critical.
- Best practice access policies for whatever cloud environment we are in. Critical for security and peace of mind for the business.
- If there is any data, there must be backups.

The following are some less critical things that I nonetheless believe should be present in a production grade website:
- Some sort of style guide, preferably enforced by a linter. To try to have some minimum level of readability. Not critical but helpful in the long run.
- Pre-commit git hooks that run the unit tests and the linter. This is not critical and can be seen as onerous, particularly if the CI/CD handles similar checks, but it enforces some degree of functional code committed to the shared repository, and it should reduce the amount of failed or frivolous pipeline runs, which can reduce the stress on whatever pipeline platform the team is using and therefore the overall cost of the project by reducing compute. It can slightly increase the length of the developer's feedback cycle, but the hope is that it improves the developer's mindfulness, and reduces the amount of scrappy commits.

We are talking about a static website at the moment, but if we moved into business logic territory, or an enterprise backend with multiple teams, it could be worthwhile splitting the system into multiple services. In this situation, particularly if there was a need for availability or solid performance, it would be worth looking into containerizing the services and hosting them in a Kubernetes cluster.
Continuing on the enterprise tangent, we would look to use a VPN for internal services to talk to each other, proxies for external internet access, and an API Gateway for external users to access our site.
To harden our system, we could use a private repository of base images for containers maintained by a specific security team, SSL certificate management tools, vulnerability scanners, and we could introduce a Quality Assurance team to handle regression and integration testing.

Time taken to answer questions: 1.5-2 hours