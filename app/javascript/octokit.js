import { Octokit, App } from "https://esm.sh/octokit";

console.log("Javascript File is executed.");

document.getElementById('github-form').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevent the form from submitting the traditional way

    const repoOwner = document.getElementById('repo-owner').value;
    const repoName = document.getElementById('repo-name').value;
    const accessToken = document.getElementById('access-token').value;
    const startDate = document.getElementById('start-date').value;
    const endDate = document.getElementById('end-date').value;


    // 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 //

    const octokit = new Octokit({
        auth: accessToken,
    });
    
    // Get a reference to the commit-list element
    const commitList = document.getElementById('commit-list');

    octokit.rest.repos.listCommits({
        owner: repoOwner,
        repo: repoName,
        since: startDate,
        until: endDate,
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
});
