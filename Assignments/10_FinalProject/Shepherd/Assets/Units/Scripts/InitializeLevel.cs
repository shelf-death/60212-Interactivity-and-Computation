using UnityEngine;
using System.Collections;

public class InitializeLevel : MonoBehaviour {

	public GameObject vassal;
	public GameObject shepherd;
	public GameObject flock;
	public GameObject arrow;
	public GameObject splitScreenCamera;

	public Material[] material;
	Renderer mesh;

	public int numTeams = 1;
	public int numWide = 5;
	public int numTall = 5;
	public float xSpacing = 3.0f;
	public float zSpacing = 3.0f;

	public GameObject Team1Start;
	public GameObject Team2Start;

	Vector3 startPos;

	// Use this for initialization
	void Start() {



		for ( int aTeam = 0; aTeam < numTeams; aTeam++ ) {

			if (aTeam == 0) {
				startPos = new Vector3 (Team1Start.transform.position.x,Team1Start.transform.position.y,Team1Start.transform.position.z);
			}

			else {
				startPos = new Vector3 (Team2Start.transform.position.x,Team2Start.transform.position.y,Team2Start.transform.position.z);
			}

			//create the team object
			GameObject newTeam = new GameObject();
			newTeam.name = "Team"+(aTeam+1);

			//create the shepherd
			GameObject newShepherd = (GameObject) Instantiate(shepherd, new Vector3(startPos.x,startPos.y,startPos.z), Quaternion.identity);
			newShepherd.transform.SetParent (newTeam.transform, false);
			newShepherd.tag = "Team"+(aTeam+1);
			newShepherd.name = "Shepherd"+(aTeam+1);//Name the Shepherd

			//create the arrowIndicator
			GameObject newArrow = (GameObject) Instantiate(arrow, new Vector3 (aTeam*xSpacing*numWide,0,aTeam*xSpacing*numWide), Quaternion.identity);
			newArrow.transform.SetParent (newTeam.transform, false);
			newArrow.tag = "Team"+(aTeam+1);																	//Tag the Arrow

			//create the arrowIndicator
			GameObject newCamera = (GameObject) Instantiate(splitScreenCamera, new Vector3 (aTeam*xSpacing*numWide,0,aTeam*xSpacing*numWide), new Quaternion(0,0,0,0));
			newCamera.transform.SetParent (newTeam.transform, false);
			newCamera.tag = "Team"+(aTeam+1);																	//Tag the Arrow


			//Change Shepherd Material to red for team 2
			if (aTeam > 0) {
				mesh = newArrow.GetComponentInChildren<Renderer> ();
				mesh.enabled = true;
				mesh.sharedMaterial = material [2];

				mesh = newShepherd.GetComponentInChildren<Renderer> ();
				mesh.enabled = true;
				mesh.sharedMaterial = material [0];
			}
		

			//create each set of vassals
			GameObject newFlock = (GameObject) Instantiate(flock, new Vector3 (0,0,0), Quaternion.identity);
			newFlock.name = "Flock"+(aTeam+1);																	//Name the object
			newFlock.transform.SetParent (newTeam.transform, false);											//Set flock parent
			newFlock.tag = "Team"+(aTeam+1);																	//Tag the flock

			//iterate over the grid to make units
			for (int z = 0; z < numTall; z++) {
				for (int x = 0; x < numWide; x++) {

					//instantiate and parent
					GameObject newVassal = (GameObject) Instantiate(vassal, new Vector3 (startPos.x + x * xSpacing, startPos.y , startPos.z + z * zSpacing), Quaternion.identity);
					newVassal.transform.SetParent (newFlock.transform, false);									//Set Vassal parent
					newVassal.tag = "Team"+(aTeam+1);															//Tag the vassal 

					if (aTeam > 0) {
						mesh = newVassal.GetComponentInChildren<Renderer> ();
						mesh.enabled = true;
						mesh.sharedMaterial = material [1];
					}

				}
			}
		}//end for each team loop
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
