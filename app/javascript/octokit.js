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
    // Handle the API response here
    const commits = response.data;
    // Create an HTML string to display the commits
    const commitsHTML = commits.map((commit) => {
        return `<p><strong>${commit.commit.author.name}</strong>: ${commit.commit.message}</p>`;
    }).join('');
    // Update the content of the commit-list element
    commitList.innerHTML = commitsHTML;
})

.catch((error) => {
    console.log("Request failed.")
    // Handle any errors here
    console.error(error);
});
