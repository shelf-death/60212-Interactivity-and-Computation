using UnityEngine;
using System.Collections;

public class ArrowController : MonoBehaviour {

		[SerializeField] Transform target;
		public float zOffset = 0.0f;
		public float yOffset = 3.0f;
		public float bobbing = 10.0f;
		public float bobSpeed = 3.0f;

		// Use this for initialization
		void Start () {

			//Subscribe to event
			Shepherd.followShepherd += HoverTarget;
		
		}

		void Update () {
			transform.position = new Vector3(
				target.position.x, 
				target.position.y + yOffset + (Mathf.Sin(Time.deltaTime / bobSpeed * Mathf.Deg2Rad)), 
				target.position.z + zOffset); 
		}

		public void HoverTarget( GameObject unit, bool noTarget){
			
			target = unit.transform;
		
		}
}
