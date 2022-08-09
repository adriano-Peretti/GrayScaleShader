using System.Collections;
using UnityEngine;

public class FadeToGray : MonoBehaviour
{
    public Renderer[] renderers;


    public void DoTheFade(int index)
    {
        StartCoroutine(DoTheFadeCR(renderers[index]));
    }

    private IEnumerator DoTheFadeCR(Renderer material)
    {
        float time = 0;
        while (time < 1f)
        {
            material.material.SetFloat("_Blend", time);
            time += Time.deltaTime;
            yield return null;
        }

        material.material.SetFloat("_Blend", 1);
    }
}