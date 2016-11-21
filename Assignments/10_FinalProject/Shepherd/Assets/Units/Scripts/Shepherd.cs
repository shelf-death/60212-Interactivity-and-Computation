using UnityEngine;
using System.Collections;

public class Shepherd : MonoBehaviour {

	public delegate void UnitEventHandler (GameObject unit);
	public static event UnitEventHandler setNavigationTarget; 

	//Function called by Shepherd to move flock
	public static void NewNavigationDestination( GameObject unit)
	{
		if (setNavigationTarget != null) {
			setNavigationTarget (unit);
		}
	}

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		
			NewNavigationDestination (this.gameObject);
	
	}
}
