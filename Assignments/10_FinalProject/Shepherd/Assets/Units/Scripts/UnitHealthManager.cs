using UnityEngine;
using System.Collections;


public class UnitHealthManager : MonoBehaviour {

	public float maxHealth = 1000.0f;
	public float currentHealth;
	public bool dying = false;


	public delegate void DeathHandler (GameObject deadVassal);
	public static event DeathHandler vassalDied;

	// Use this for initialization
	void Start () {

		//Subscribe to event
		flockCombatManager.damageDealt += damageEventRecieved;

		currentHealth = maxHealth; //Set health to max when created
	
	}
	
	// Update is called once per frame
	void Update () {

		deathCheck();
	
	}

	void OnDestroy() {

		//Unsubscribe to event
		flockCombatManager.damageDealt -= damageEventRecieved;

	}

	void damageEventRecieved (GameObject attacker, GameObject victim, float damage) {

		if (victim != null && this.gameObject != null) {
			if (victim == this.gameObject) {
				decrementHealth (damage);
			}
		}
	}

	void decrementHealth (float amount)
	{
		currentHealth -= amount; 
	}

	void deathCheck() 
	{
		if (this.gameObject != null) { 
			if (currentHealth <= 0.0f) {
				dying = true;
				SendDeathEvent (this.gameObject);
			}
		}
	}

	void SendDeathEvent (GameObject deadVassal) {
		if (vassalDied != null) {
			vassalDied (deadVassal);
		} 
	}

}//end class


