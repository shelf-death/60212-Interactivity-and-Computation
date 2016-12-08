using UnityEngine;
using System.Collections;

public class RandomizeRunSpeed : MonoBehaviour {

	public float minSpeed = 2.0f;
	public float maxSpeed = 4.0f;

	// Use this for initialization
	void Start () {

		this.GetComponent<NavMeshAgent>().speed  = Random.Range (minSpeed, maxSpeed);
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
