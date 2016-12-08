using UnityEngine;
using System.Collections;
using UnityStandardAssets.CrossPlatformInput;

public class Shepherd : MonoBehaviour {

		public delegate void UnitEventHandler (GameObject unit, bool noTarget);
		public static event UnitEventHandler followShepherd; 

		public bool following = false;
		public GameObject enemyFlock;
		public GameObject closestEnemy;

		//Function called by Shepherd to move flock
		public static void NewNavigationDestination( GameObject unit , bool noTarget)
		{
			if (followShepherd != null) {
				followShepherd (unit, noTarget);
			}
		}

		// Use this for initialization
		void Start () {

		//Subscribe to combat toggle event
		UnityStandardAssets.Characters.ThirdPerson.ThirdPersonUserControl.toggleAttackState += AttackToggled;

		//find enemy team
		if (this.gameObject.tag == "Team1") {
			enemyFlock = GameObject.Find ("Flock2");
		}

		if (this.gameObject.tag == "Team2") {
			enemyFlock = GameObject.Find ("Flock1");
		}

		}
		
		// Update is called once per frame
		void Update () {
			//sets new flock target on either itself or on nearest enemy vassal. if no enemy vassals exist, movement is disabled.

			if (following == true) {
				NewNavigationDestination (this.gameObject, false);
			} 
			else {
			findNearestEnemy (enemyFlock);
			NewNavigationDestination (closestEnemy , false);
			}
		}

		public void AttackToggled (string team, bool attacking) {

			if (team == this.gameObject.tag) {
			following = !following;
			}
		
		}

	public void findNearestEnemy (GameObject _enemyFlock) {
		float minDistance = 999999.0f;
		float dist = 0.0f;
		foreach (Transform child in _enemyFlock.transform) {
			if (child.gameObject != null) {
				dist = Vector3.Distance (child.position, this.transform.position);
				if (dist < minDistance) {
					minDistance = dist;
					closestEnemy = child.gameObject;
				}
			}
		}

	} //end find nearest enemy

} //end of class 
