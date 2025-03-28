class ajynks_scaleTool
{
    // Static method to return an integer
    static int setPosX(float slideValue)
    {
        int screenX = Screen.GetWidth();
        float slider = slideValue;
        return (slider * screenX) / 100;
    }

    static int setPosY(float slideValue)
    {
        int screenY = Screen.GetHeight();
        float slider = slideValue;
        return (slider * screenY) / 100;
    }
}