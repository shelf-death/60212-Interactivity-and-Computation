using UnityEngine;
using System.Collections;

public class CameraController : MonoBehaviour {

	public Transform target;
	public float zOffset = -50.0f;
	public float yOffset = 20.0f;

	// Use this for initialization
	void Start () {

		if (this.gameObject.tag == "Team1") {
			target = GameObject.Find ("Shepherd1").transform;
		} 
		if (this.gameObject.tag == "Team2")
		{
			target = GameObject.Find ("Shepherd2").transform;
		}
	
	}

	void Update () {

		transform.position = new Vector3(
			target.position.x, 
			target.position.y + yOffset, 
			target.position.z + zOffset); 
	}
}
