import { Octokit, App } from "https://esm.sh/octokit";

console.log("Javascript File is executed.");

document.getElementById('github-form').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevent the form from submitting the traditional way

    const repoOwner = document.getElementById('repo-owner').value;
    const repoName = document.getElementById('repo-name').value;
    const accessToken = document.getElementById('access-token').value;
    const startDate = document.getElementById('start-date').value;
    const endDate = document.getElementById('end-date').value;

    const octokit = new Octokit({
        auth: accessToken,
    });
    
    // Get a reference to the commit-table and its tbody
    const commitTable = document.getElementById('commit-table');
    const commitTableBody = commitTable.querySelector('tbody');


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

        const authorCommits = {};

        commits.forEach((commit) => {
            const author = commit.commit.author.name;
            if (authorCommits[author]) {
                authorCommits[author]++;
            } else {
                authorCommits[author] = 1;
            }
        });

        // Clear the table body
        commitTableBody.innerHTML = '';

        // Populate the table with author commit data
        for (const author in authorCommits) {
            const row = commitTableBody.insertRow();
            const cell1 = row.insertCell(0);
            const cell2 = row.insertCell(1);
            cell1.textContent = author;
            cell2.textContent = authorCommits[author];
        }

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
