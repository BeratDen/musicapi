from django.db import models
from django.utils.translation import gettext as _

# Create your models here.

class Category(models.Model):

    class Meta:
        verbose_name_plural = _("Categories")

    name = models.CharField(_("Name"), max_length=50)
    description = models.TextField(blank=True, null=True, verbose_name='Category Description')
    slug = models.SlugField(default="",null=False)
    created_at = models.DateTimeField(auto_now_add=True, verbose_name='Created At')
    updated_at = models.DateTimeField(auto_now=True, verbose_name='Updated At')

    def __str__(self) -> str:
        return f"{self.name}"

class Musician(models.Model):
    first_name = models.CharField(_("First Name"), max_length=50)
    last_name = models.CharField(_("Last Name"), max_length=50)
    slug = models.SlugField(default="",null=False)
    resume = models.TextField(_("Resume"),blank=True, null=True,)
    category = models.ManyToManyField(Category, verbose_name=_("Category"))

    def __str__(self) -> str:
        return f"{self.first_name} {self.last_name}"

class Album(models.Model):
    name = models.CharField(_("Name"), max_length=50)
    slug = models.SlugField(default="",null=False)
    artist = models.ForeignKey(Musician, verbose_name=_("Artist"), on_delete=models.CASCADE)
    release_date = models.DateField(_("Relase Date"))
    num_stars = models.IntegerField(_("Stars"))

    def __str__(self) -> str:
        return f"{self.name}"

class Music(models.Model):
    name = models.CharField(_("Name"), max_length=50)
    slug = models.SlugField(default="",null=False)
    lyric = models.TextField(_("Lyric"),null=True,blank=True)
    artist = models.ForeignKey(Musician, verbose_name=_("Artist"), on_delete=models.CASCADE)
    category = models.ManyToManyField(Category, verbose_name=_("Category"))
    album = models.ForeignKey(Album, verbose_name=_(""), on_delete=models.CASCADE)
    music_url = models.URLField(_("Music Path"), max_length=200,null=True,blank=True)
    image_url = models.URLField(_("Image Path"), max_length=200,null=True,blank=True)
    video_url = models.URLField(_("Video Path"), max_length=200,null=True,blank=True)
    release_date = models.DateField(_("Relase Date"))
    num_stars = models.IntegerField(_("Stars"))


