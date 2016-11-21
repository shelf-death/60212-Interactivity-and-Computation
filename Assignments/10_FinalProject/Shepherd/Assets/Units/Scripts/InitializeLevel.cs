using UnityEngine;
using System.Collections;

public class InitializeLevel : MonoBehaviour {

	public Transform vassal;
	public float xSpacing = 3.0f;
	public float zSpacing = 3.0f;

	// Use this for initialization
	void Start() {
		for (int z = 0; z < 10; z++) {
			for (int x = 0; x < 10; x++) {
				Instantiate(vassal, new Vector3(x*xSpacing, 0, z*zSpacing), Quaternion.identity);
			}
		}
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
