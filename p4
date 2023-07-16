Step 1 - Create a repository
1. Log in to GitHub and begin the process to create a new repository.
2. Enter a name for your repository (for example, hello-world).
3. Select the option to initialize the repository with a README file.
4. Finally, click Create repository.
5. There is no need to add any source code for now.


Login to Circle CI https://app.circleci.com/ Using GitHub Login, Once logged in navigate to Projects.


Step 2 - Set up CircleCI
1. Navigate to the CircleCI Projects page. If you created your new repository under an organization, you will need to
select the organization name.
2. You will be taken to the Projects dashboard. On the dashboard, select the project you want to set up (hello-world).
3. Select the option to commit a starter CI pipeline to a new branch, and click Set Up Project. This will create a file
.circleci/config.yml at the root of your repository on a new branch called circleci-project-setup.

Step 3 - Your first pipeline
On your project’s pipeline page, click the green Success button, which brings you to the workflow that ran (say-hello-
workflow).
Within this workflow, the pipeline ran one job, called say-hello. Click say-hello to see the steps in this job:
a. Spin up environment
b. Preparing environment variables
c. Checkout code
d. Say hello
Now select the “say-hello-workflow” to the right of Success status column

Select “say-hello” Job with a green tick


Select Branch and option circleci-project-setupStep 4 - Break your build
In this section, you will edit the .circleci/config.yml file and see what happens if a build does not complete successfully. 
It is possible to edit files directly on GitHub. 



Replace the existing code with new code: 
version: 2.1 
orbs: 
node: cricleci/node@4.7.0 
jobs: 
build: 
executor: 
name: node/default
tag: '10.4' 
steps: 
- checkout 
- node/with-cache: 
steps: 
- run: npm install 
-run: npm run test


Scroll down and Commit your changes on GitHub


After committing your changes, then return to the Projects page in CircleCI. You should see a new pipeline running... and it will fail! What’s going on? The Node orb runs some common Node tasks. Because you are working with an empty repository, running npm run test, a Node script, causes the configuration to fail. To fix this, you need to set up a Node project in your repository. 

Step 5 – Use Workflows
You do not have to use orbs to use CircleCI. The following example details how to create a custom configuration that alsouses the workflow feature of CircleCI.
1) Take a moment and read the comments in the code block below. Then, to see workflows in action, edityour .circleci/config.yml file and copy and paste the following text into it.
version: 2.1
jobs: 
  one: 
     docker: 
      - image: cimg/ruby:2.6.8 
        auth:
          username: mydockerhub-user
          password: $DOCKERHUB_PASSWORD
     steps: 
      - checkout 
      - run: echo "A first hello" 
      - run: sleep 25 
  two: 
     docker: 
       - image: cimg/ruby:3.0.2 
         auth:
           username: mydockerhub-user
           password: $DOCKERHUB_PASSWORD
     steps: 
      - checkout 
      - run: echo "A more familiar hi" 
      - run: sleep 15 
workflows: 
  version: 2.1
  one_and_two: 
     jobs: 
       - one 
       - two

Commit these changes to your repository and navigate back to the CircleCI Pipelines page. You should see your pipeline running. 

Click on the running pipeline to view the workflow you have created. You should see that two jobs ran (or are currently running!) concurrently. 


Step 5 – Add some changes to use workspaces
Each workflow has an associated workspace which can be used to transfer files to downstream jobs as the workflow
progresses. You can use workspaces to pass along data that is unique to this run and which is needed for downstream
jobs. Try updating config.yml to the following:
version: 2.1 
jobs: 
  one: 
    docker: 
      - image: cimg/ruby:3.0.2 
        auth:
          username: mydockerhub-user
          password: $DOCKERHUB_PASSWORD
    steps: 
      - checkout 
      - run: echo "A first hello" 
      - run: mkdir -p my_workspace
      - run: echo "Trying out workspaces" >my_workspace/echo-output 
      - persist_to_workspace: 
          root: my_workspace

          paths: 
           - echo-output 
  two: 
    docker: 
      - image: cimg/ruby:3.0.2
        auth:
          username: mydockerhub-user
          password: $DOCKERHUB_PASSWORD
    steps: 
      - checkout 
      - run: echo "A more familiar hi"
      - attach_workspace: 
            at: my_workspace
      - run: | 
          if [[ $(cat my_workspace/echo-output) == "Trying out workspaces"]]; 
            then echo "It worked!"; 
          else
            echo "Nope!"; exit 1
          fi
workflows: 
  version: 2.1
one_and_two: 
    jobs: 
      - one 
      - two: 
          requires: 
            - one
version: 2.1
jobs: 
  one: 
    docker: 
      - image: cimg/ruby:3.0.2 
        auth:
          username: mydockerhub-user
          password: $DOCKERHUB_PASSWORD
    steps: 
      - checkout 
      - run: echo "A first hello" 
      - run: mkdir -p my_workspace
      - run: echo "Trying out workspaces" >my_workspace/echo-output 
      - persist_to_workspace: 
          root: my_workspace
 
          paths: 
           - echo-output 
  two: 
    docker: 
      - image: cimg/ruby:3.0.2
        auth:
          username: mydockerhub-user
          password: $DOCKERHUB_PASSWORD
    steps: 
      - checkout 
      - run: echo "A more familiar hi"
      - attach_workspace: 
            at: my_workspace
      - run: | 
          "Trying out workspaces" >my_workspace/echo-output
            then echo "It worked!"; 
          else
            echo "Nope!";
          fi
workflows: 
  version: 2.1
  one_and_two: 
    jobs: 
      - one 
      - two: 
          requires: 
            - one

Finally, your workflow with the jobs running should look like this 
