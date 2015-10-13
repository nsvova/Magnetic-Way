using UnityEngine;


public class Finish : MonoBehaviour {

	void OnTriggerEnter2D(Collider2D other)
    {
        if(other.gameObject.tag == "Player")
        {
            Debug.Log("Well Done"); // TODO UI
            Application.LoadLevel("");//next level; TODO when level id's will availoble
        }
    }
}
