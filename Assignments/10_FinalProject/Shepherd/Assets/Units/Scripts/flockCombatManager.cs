using UnityEngine;
using System.Collections.Generic;

public class flockCombatManager : MonoBehaviour {

	public delegate void CombatEventHandler (GameObject attacker, GameObject victim, float damage);
	public static event CombatEventHandler damageDealt;

	public bool attacking = false;
	public float vassalDamagePower = 0.1f;
	public float combatDistance = 3.0f;

	public GameObject enemyFlock;
	public List<UnitHealthManager> Vassals = new List<UnitHealthManager>();

	//Function called by Shepherd to move flock
	public static void AttackTarget (GameObject attacker, GameObject victim,float damageAmt)
	{
	
		if (damageDealt != null) {
			damageDealt (attacker,victim,damageAmt);
		}
	
	}

	// Use this for initialization
	void Start () {

		//find enemy flock
		if (this.gameObject.tag == "Team1") {
			enemyFlock = GameObject.Find ("Flock2");
		}

		if (this.gameObject.tag == "Team2") {
			enemyFlock = GameObject.Find ("Flock1");
		}

		//Subscribe to combat toggle event
		UnityStandardAssets.Characters.ThirdPerson.ThirdPersonUserControl.toggleAttackState += AttackToggled;
		UnitHealthManager.vassalDied += DeleteDeadVassal;

		Vassals.AddRange(GetComponentsInChildren<UnitHealthManager>());
	
	}
	
	// Update is called once per frame
	void Update () {

		if (attacking == true) {
			foreach (var vassal in Vassals) {
					if (vassal.gameObject) {
						distanceDamageCheck (vassal.gameObject, enemyFlock);
					}
			}
		}
	} //end update
		
	void AttackToggled(string team, bool _attacking) {
		if (team == this.gameObject.tag) {
			attacking = _attacking;
		}
	}

	void DeleteDeadVassal(GameObject deadVassal) {
		if (deadVassal.tag == this.gameObject.tag) {
			Destroy (deadVassal);
		}
	}

	void distanceDamageCheck (GameObject _vassal, GameObject _enemyFlock)
	{
		float dist;
		foreach (Transform enemyChild in _enemyFlock.transform) {
			if (enemyChild.gameObject != null) {
				dist = Vector3.Distance (enemyChild.position, _vassal.transform.position);
				if (dist <= combatDistance && attacking == true) {
					AttackTarget (_vassal, enemyChild.gameObject, vassalDamagePower);
				}
			}
		}
	}
}
