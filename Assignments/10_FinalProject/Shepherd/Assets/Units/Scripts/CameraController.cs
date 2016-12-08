using UnityEngine;
using System.Collections;

public class CameraController : MonoBehaviour {

	[SerializeField] Transform target;
	public float zOffset = -50.0f;
	public float yOffset = 20.0f;

	// Use this for initialization
	void Start () {
	
	}

	void Update () {
		transform.position = new Vector3(
			target.position.x, 
			target.position.y + yOffset, 
			target.position.z + zOffset); 
	}
}
