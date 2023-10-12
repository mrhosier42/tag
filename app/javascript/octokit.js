import { Octokit, App } from "https://esm.sh/octokit";

console.log("Javascript File is executed.");

const octokit = new Octokit({
    auth: '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',
  });
  
// Get a reference to the commit-list element
const commitList = document.getElementById('commit-list');

octokit.rest.repos.listCommits({
    owner: 'mrhosier42',
    repo: 'tag',
})

.then((response) => {
    // Handles the API response
    const commits = response.data;

    console.log(commits)

    // Create an HTML string to display the commits
    const commitsHTML = commits.map((commit) => {
        return `<p><strong>${commit.commit.author.name}</strong>: ${commit.commit.message}</p>`;
    }).join('');

    // Update the content of the commit-list element
    commitList.innerHTML = commitsHTML;
})

.catch((error) => {
    console.log("Request failed.")
    
    // Handles errors
    console.error(error);
});
