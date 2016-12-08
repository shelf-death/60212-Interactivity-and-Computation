using System;
using UnityEngine;
using UnityStandardAssets.CrossPlatformInput;

namespace UnityStandardAssets.Characters.ThirdPerson
{
    [RequireComponent(typeof (ThirdPersonCharacter))]
    public class ThirdPersonUserControl : MonoBehaviour
    {
		//Attack toggle event
		public delegate void InputEventHandler (string team, bool attacking);
		public static event InputEventHandler toggleAttackState;

		public bool t1AtkBool = false;
		public bool t2AtkBool = false;

        private ThirdPersonCharacter m_Character; // A reference to the ThirdPersonCharacter on the object
        private Transform m_Cam;                  // A reference to the main camera in the scenes transform
        private Vector3 m_CamForward;             // The current forward direction of the camera
        private Vector3 m_Move;
        private bool m_Jump;                      // the world-relative desired move direction, calculated from the camForward and user input.

        
        private void Start()
        {
            // get the transform of the main camera
            if (Camera.main != null)
            {
                m_Cam = Camera.main.transform;
            }
            else
            {
//                Debug.LogWarning(
//                    "Warning: no main camera found. Third person character needs a Camera tagged \"MainCamera\", for camera-relative controls.", gameObject);
                // we use self-relative controls in this case, which probably isn't what the user wants, but hey, we warned them!
            }

            // get the third person character ( this should never be null due to require component )
            m_Character = GetComponent<ThirdPersonCharacter>();
        }


        private void Update()
        {
			//Toggle attacking team 1
			if (Input.GetKeyUp(KeyCode.Q)) {
				if (this.gameObject.tag == "Team1") {
					t1AtkBool = !t1AtkBool;
					SendAttackState ("Team1", t1AtkBool);
				}
			}

			//Toggle attacking team 2
			if (Input.GetKeyUp(KeyCode.RightShift)) {
				if (this.gameObject.tag == "Team2") {
					t2AtkBool = !t2AtkBool;
					SendAttackState ("Team2", t2AtkBool);
				}
			}

            if (!m_Jump)
            {
                m_Jump = CrossPlatformInputManager.GetButtonDown("Jump");
            }
        }


        // Fixed update is called in sync with physics
        private void FixedUpdate()
        {

			float v = 0.0f;
			float h = 0.0f;
            // read inputs
			if (this.gameObject.tag == "Team1") {
            	 h = CrossPlatformInputManager.GetAxis("HorizontalWASD");
            	 v = CrossPlatformInputManager.GetAxis("VerticalWASD");
			}
			if (this.gameObject.tag == "Team2") {
				 h = CrossPlatformInputManager.GetAxis("HorizontalArrow");
				 v = CrossPlatformInputManager.GetAxis("VerticalArrow");
			}

            bool crouch = Input.GetKey(KeyCode.C);

            // calculate move direction to pass to character
            if (m_Cam != null)
            {
                // calculate camera relative direction to move:
                m_CamForward = Vector3.Scale(m_Cam.forward, new Vector3(1, 0, 1)).normalized;
                m_Move = v*m_CamForward + h*m_Cam.right;
            }
            else
            {
                // we use world-relative directions in the case of no main camera
                m_Move = v*Vector3.forward + h*Vector3.right;
            }
#if !MOBILE_INPUT
			// walk speed multiplier
	        if (Input.GetKey(KeyCode.LeftShift)) m_Move *= 0.5f;
#endif

            // pass all parameters to the character control script
            m_Character.Move(m_Move, crouch, m_Jump);
            m_Jump = false;
        }
    
		//Event-sending message
		public static void SendAttackState(string team, bool attacking) {
		
			if (toggleAttackState != null) {
				toggleAttackState (team, attacking);
			}

		}
	
	}
}
